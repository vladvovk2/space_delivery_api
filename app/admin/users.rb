ActiveAdmin.register User do
  menu priority: 2
  actions :all, except: %i[edit destroy]

  filter :first_name
  filter :last_name
  filter :email
  filter :phone_number
  filter :verification

  index do
    id_column
    column :first_name
    column :last_name
    column :email
    column :phone_number
    column :verification
    column :created_at
    actions
  end

  show do

  end
end
