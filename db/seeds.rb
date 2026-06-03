User.find_or_create_by!(email: "demo@example.com") do |u|
  u.password              = "demo1234"
  u.password_confirmation = "demo1234"
  u.role                  = :admin
end
