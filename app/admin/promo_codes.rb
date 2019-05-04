ActiveAdmin.register PromoCode do
  menu priority: 6
  actions :all, except: %i[edit destroy show]

  permit_params :amount, :percentage, :limitation, :category_id

  controller do
    def scoped_collection
      super.includes(:category, :order, :user)
    end

    def create
      SendPromocodeJob.perform_later(permitted_params[:promo_code])
      redirect_to admin_promo_codes_path
    end
  end

  index do
    id_column
    column :code
    column(:user, &:user)
    column(:order, &:order)
    column(:category, &:category)
    column(:amount) { |promocode| promocode.percentage ? "#{promocode.amount}%" : "#{promocode.amount}грн." }
    column :invite
    column :percentage
    column :used
    column :limitation
    column :created_at
  end

  form(html: { multipart: true }) do |f|
    f.semantic_errors
    f.inputs 'Atributes' do
      f.input :amount
      f.input :percentage
      f.input :limitation
      f.input :category, as: :select, collection: Category.all
    end
    f.actions
  end
end
