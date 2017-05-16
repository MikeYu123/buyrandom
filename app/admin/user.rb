ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
menu :if => -> { current_user&.admin? }
permit_params :email, :password, :password_confirmation, :balance, :role, :avatar_url, :username

form do |f|
  f.inputs do
    f.input :email
    f.input :password
    f.input :password_confirmation
    f.input :balance
    f.input :role
    f.input :avatar_url
    f.input :username
  end
  f.submit
end

controller do
  before_filter :admin_filter

  def admin_filter
    raise ActionController::RoutingError.new('Not Found') unless current_user.admin?
  end
end

index do
  column :id
  column :email
  column :role
  column :balance
  column :avatar_url
  column :uid
  column :username
end

show do
  attributes_table do
    row :email
    row :role
    row :balance
    row :avatar_url
    row :created_at
    row :updated_at
    row :username
  end
end
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
