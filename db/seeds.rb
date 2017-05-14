
# CARDS SEEDER

color = ["red", "green", "blue"]
symbol = ["ovals", "squiggles", "diamonds"]
number = [1,2,3]
shading = ["solid", "open", "lines"]
# c is 81 combinations of color, symbol, number and shading as an array
c = color.product(symbol, number, shading)

i = 0
while i < c.length
  Card.create(image: "/cards/#{c[i][0][0]+c[i][1][0]+c[i][2].to_s+c[i][3][0]}.png", color: c[i][0], symbol: c[i][1], number: c[i][2], shading: c[i][3])
  i += 1
end


User.create(first_name: "Test", last_name: "Tester",username: "TTest", email: "test@test.com", password: "test1234", phone_number: '+18707406052' )
