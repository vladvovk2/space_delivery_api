ActiveAdmin.register Order do
  menu priority: 3
  actions :all, except: %i[edit destroy]

end
