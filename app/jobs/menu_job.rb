class MenuJob
  def perform(identifier)
    @identifier = identifier

    batch = Sidekiq::Batch.new
    batch.callback_queue = 'messages'
    batch.on(:success, MenuJob::Create, @identifier)
    batch.jobs do
      GenerateMenuWorker.perform_async(@identifier)
    end
  end

  class Create
    def on_success(_status, identifier)
      DeleteMenuWorker.perform_in(10.minutes, identifier)
    end
  end
end
