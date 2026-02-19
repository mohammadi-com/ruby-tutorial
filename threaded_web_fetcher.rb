require "net/http"
require "uri"
require "timeout"
require "thread"

URLS = [
  "https://example.com",
  "https://www.ruby-lang.org/en/",
  "https://www.wikipedia.org/",
  "https://httpbin.org/status/404",
  "https://httpbin.org/delay/2"
]

# class ThreadedWebFetcher
#   attr_reader :urls, :concurrency

#   def initialize(urls, concurrency = 3)
#     @urls = urls
#     @concurrency = concurrency
#   end

#   def run
#     index = 0
#     threads = []
#     mutex = Mutex.new

#     concurrency.times do
#       threads << Thread.new do
#         while index < @urls.length
#           mutex.synchronize {index += 1}
#           get(@urls[index-1])
#         end
#       end
#     end

#     threads.each(&:join)
#   end

#   private
#   def get(url)
#     start = nil
#     elapsed_ms = nil
#     response = nil

#     begin
#       Timeout.timeout(1) do
#         start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
#         response = Net::HTTP.get_response(URI(url))
#         elapsed_ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - start) * 1000).round
#       end
#     rescue Timeout::Error
#       puts "TIMEOUT    1000ms    #{url}"
#     rescue StandardError => e
#       puts "Execution failed: #{e.message}"
#     else
#       puts "#{response.code}    #{elapsed_ms}ms    #{url}"  # we put it here so the printing process doesn't count in 1000ms
#     end
#   end
# end


class ThreadedWebFetcher
  def initialize(urls, concurrency = 3, timeout_s = 1)
    @urls = urls
    @concurrency = concurrency
    @timeout_s = timeout_s
  end

  def run
    work_q = Queue.new
    @urls.each { |u| work_q << u }
    @concurrency.times { work_q << nil }  # sentinel per worker

    results = []
    results_mutex = Mutex.new

    threads = Array.new(@concurrency) do
      Thread.new do
        loop do
          url = work_q.pop  # variables defined in the Thread's do...end block are not shared between threads.
          break if url.nil?
          r = fetch_one(url)
          results_mutex.synchronize { results << r }
        end
      end
    end

    threads.each(&:join)

    results.sort_by { |r| r[:ms] }.each do |r|
      if r[:status] == "TIMEOUT"
        puts "TIMEOUT #{@timeout_s * 1000}ms #{r[:url]}"
      else
        puts "#{r[:status]}  #{r[:ms]}ms  #{r[:url]}"
      end
    end
  end

  private

  def fetch_one(url)
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    begin
      status = nil
      Timeout.timeout(@timeout_s) do
        status = Net::HTTP.get_response(URI(url)).code
      end
      ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - start) * 1000).round
      { url: url, status: status, ms: ms }
    rescue Timeout::Error
      { url: url, status: "TIMEOUT", ms: (@timeout_s * 1000).to_i }
    rescue StandardError
      ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - start) * 1000).round
      { url: url, status: "ERROR", ms: ms }
    end
  end
end


my_threaded_web_fetcher = ThreadedWebFetcher.new(URLS)
my_threaded_web_fetcher.run
