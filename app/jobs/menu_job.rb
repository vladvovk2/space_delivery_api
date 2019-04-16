class MenuJob
  def perform
    @time = Time.now.strftime('%F-%R')

    batch = Sidekiq::Batch.new
    batch.callback_queue = 'messages'
    batch.on(:success, MenuJob::Create, @time)
    batch.jobs do
      GenerateMenuWorker.perform_async(@time)
    end
  end

  class Create
    def on_success(_status, time)
      DeleteMenuWorker.perform_in(10.minutes, time)
    end
  end
end
