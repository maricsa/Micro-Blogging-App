# User.delete_all
# Posts.delete.all // if these are commented on, they will delete all users and posts currently in database.



users = User.create([
	{fname: "Tom", lname: "Bombadil", username: "tbombadil", },









	])

Posts.create([
	{user_id: users.sample.id, title: "jladkfj lafdskfjlaksdjflkadjflka jdfklaj lak", body: "lkadjfla jsdflkjsalkfjaslkfjaslkfjalks"},
	{user_id: users.sample.id, title: "jladkfj lafdskfjlaksdjflkadjflka jdfklaj lak", body: "lkadjfla jsdflkjsalkfjaslkfjaslkfjalks"},

	])