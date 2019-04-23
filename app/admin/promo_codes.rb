ActiveAdmin.register PromoCode do
  menu priority: 6
  actions :all, except: %i[edit destroy show]

  permit_params :amount, :percentage, :limitation

  index do
    id_column
    column :code
    column(:user, &:user)
    column(:order, &:order)
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
    end
    f.actions
  end
end
