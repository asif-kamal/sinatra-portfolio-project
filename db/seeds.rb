BookLanguage.create(book_id: 1, language: "Japanese")
BookLanguage.create(book_id: 1, language: "Spanish")
BookLanguage.create(book_id: 2, language: "Sanskrit")
BookLanguage.create(book_id: 2, language: "English")



User.create(name: "Jake", email: "jake@yahoo.com", password: "secret")
User.create(name: "Malibu", email: "malibu@yahoo.com", password: "asdf")



Book.create(title: "Theory of New Physics", year_published: 2007, topics: "How The Past does not create the Present.", author: "Hisako Moramoto", book_language_id: 1, user_id: 1)
Book.create(title: "Don Quixote", year_published: 1677, topics: "Story about a man and his travels.", author: "Eduoardo Munez", book_language_id: 2, user_id: 1)
Book.create(title: "Rig Veda", year_published: 0, topics: "The written word by seers.", author: "Unknown", book_language_id: 3, user_id: 3)
