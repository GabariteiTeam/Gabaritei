role_admin = Role.all.first

#if Rails.env == 'development'

# ADMIN USER
user = User.new
user.first_name = 'Sophia'
user.last_name = 'Carvalho Fernandes'
user.email = 'scf@gabaritei.com'
user.birthdate = DateTime.parse("1970-01-01")
user.password = '12345678'
user.password_confirmation = '12345678'
user.role = role_admin
user.setting = Setting.new
user.setting.preferred_language = 0
user.save!

#else

# ADMIN USER
# user = User.new
# user.first_name = 'Admin'
# user.last_name = 'Admin'
# user.email = 'admin@admin.com'
# user.birthdate = DateTime.parse("1970-01-01")
# user.password = '12345678'
# user.password_confirmation = '12345678'
# user.role = role_admin
# user.setting = Setting.new
# user.setting.preferred_language = 0
# user.save!

#end