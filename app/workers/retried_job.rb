require 'resque/errors'
module RetriedJob
  def on_failure_retry(e, *args)
    puts "[Failure] #{self}(#{args}) caused an exception (#{e}). Retrying..."
    $stdout.flush
    Resque.enqueue self, *args
  end
end