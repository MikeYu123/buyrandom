module ApplicationHelper
	def set_active controller
		controller_name == controller ? 'active' : ''
	end
end
