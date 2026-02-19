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

class ThreadedWebFetcher
  attr_reader :urls, :concurrency

  def initialize(urls, concurrency = 3)
    @urls = urls
    @concurrency = concurrency
  end

  def run
    index = 0
    threads = []
    mutex = Mutex.new

    concurrency.times do
      threads << Thread.new do
        while index < @urls.length
          mutex.synchronize {index += 1}
          get(@urls[index-1])
        end
      end
    end

    threads.each(&:join)
  end

  private
  def get(url)
    start = nil
    elapsed_ms = nil
    response = nil

    begin
      Timeout.timeout(1) do
        start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        response = Net::HTTP.get_response(URI(url))
        elapsed_ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - start) * 1000).round
      end
    rescue Timeout::Error
      puts "TIMEOUT    1000ms    #{url}"
    rescue StandardError => e
      puts "Execution failed: #{e.message}"
    else
      puts "#{response.code}    #{elapsed_ms}ms    #{url}"  # we put it here so the printing process doesn't count in 1000ms
    end
  end
end

my_threaded_web_fetcher = ThreadedWebFetcher.new(URLS)
my_threaded_web_fetcher.run
