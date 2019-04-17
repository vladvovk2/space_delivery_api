class MenuJob
  def perform(identifier)
    @identifier = identifier

    batch = Sidekiq::Batch.new
    batch.callback_queue = :pdf
    batch.on(:success, MenuJob::Create, @identifier)
    batch.jobs do
      GenerateMenuJob.perform_later(@identifier)
    end
  end

  class Create
    def on_success(_status, identifier)
      DeleteMenuJob.set(wait: 10.minutes).perform_later(identifier)
    end
  end
end
