class FormOptions < ActiveRecord::Base
	LEVELS = [1,2,3,4,5]
	COURSES = ['appetizer', 'main', 'dessert', 'beverage']
	RECIPE_PRIVACY =['public', 'friends-only', 'private']
end
