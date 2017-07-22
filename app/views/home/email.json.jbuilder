json.array! @emails do |email|
  json.extract! email, :id, :subject, :content, :to, :from, :date
  json.url email_url(email, format: json)
end

# {
#     "emails": [
#
#         {
#             "group": "Today April 23",
#             "list": [
#             <% @emails.each do |m| %>
#           { "id" : "<%= m.id %>",
#             "subject": "<%= m.subject %>",
#             "to": "<%= m.to %>",
#             "body": "<%= m.content %>",
#             "time": "15 Mins ago",
#             "datetime" : "<%= m.date %>",
#             "from": "<%= m.from %>",
#             "dp": "assets/img/profiles/avatar.jpg",
#             "dpRetina": "assets/img/profiles/avatar2x.jpg"
#           },
#           <% end %>
#             ]
#             }, {
#                     "group": "Yesterday April 22",
#                     "list": [{
#                                  "id": 6,
#                                  "subject": "Good design is obvious. Great design is transparent",
#                                  "to": ["John Doe", "Anne Simons"],
#                                  "body": "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sodales, velit at laoreet hendrerit, tellus dui aliquet est, ac cursus velit erat et est. Quisque vitae tortor nibh. Aliquam ornare, augue ac pulvinar euismod, mi felis cursus nisl, non ultrices lacus turpis sit amet lacus. Vestibulum in lacus ut augue tincidunt lobortis id quis mauris. Morbi at fringilla lectus, non consectetur ante. Duis eleifend quis eros eu vulputate. Praesent sit amet dolor eros. Ut aliquam eros sed ante facilisis, ac venenatis diam feugiat.</p><p>Phasellus est massa, luctus eget volutpat id, semper nec elit. Nam ligula nunc, pharetra ac sodales porta, consectetur in est. Suspendisse mauris mauris, sagittis eu tristique ac, lacinia sed nisl. Nulla ut eros ac erat dignissim pellentesque sit amet ut tellus. Nunc at risus sed lacus commodo fringilla. Curabitur laoreet condimentum facilisis. Donec eget pellentesque massa.</p> ",
#                                  "time": "1:33pm",
#                                  "datetime" : "Today at 1:33pm",
#                                  "from": "David Nester",
#                                  "dp": "assets/img/profiles/b.jpg",
#                                  "dpRetina": "assets/img/profiles/b2x.jpg"
#                              }, {
#                                  "id": 7,
#                                  "subject": "Your site has some very imaginative animation /movement, especially the Sluggo! ",
#                                  "to": ["Anne Simons"],
#                                  "body": "<p>Dear Kristen:<br>I saw your listing on Craigslist.com for a website designer for your tee-shirt company. I'm attaching my resume even though it doesn't list my extensive tee-shirt folding experience. :)<br><br>Your site has some very imaginative animation/movement, especially the Sluggo! I look forward to talking with you about how I may be of help.<br>Lillian Black</p> ",
#                                  "time": "45 mins ago",
#                                  "datetime" : "Today at 1:33pm",
#                                  "from": "Anne Simons",
#                                  "dp": "assets/img/profiles/5.jpg",
#                                  "dpRetina": "assets/img/profiles/5x.jpg"
#                              }, {
#                                  "id": 8,
#                                  "subject": "Aliquam est tellus, fringilla egestas fermentum quis",
#                                  "to": ["John Doe", "Anne Simons"],
#                                  "body": "<p> Morbi mauris dui, sollicitudin ut ipsum nec, porta malesuada justo. In eget tempor lacus. In dapibus, mi id tempor mattis, orci dolor hendrerit mauris, a aliquam purus tellus id ipsum. Praesent id turpis metus. Mauris tempus nulla et magna euismod, pharetra sodales turpis sagittis. In ultricies erat turpis, sit amet venenatis elit malesuada eget. Quisque sodales ante mauris, eget tempus mauris molestie vel. In tristique augue sed quam dignissim, tempor facilisis neque malesuada. In sagittis placerat lectus, nec mattis felis aliquam eu. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vitae rutrum nibh. Maecenas scelerisque risus mauris, in ullamcorper nulla cursus ut. Integer a pharetra elit, vel pellentesque lectus. Ut erat tortor, euismod vel massa non, fringilla auctor neque.</p> ",
#                                  "time": "1:33pm",
#                                  "datetime" : "Today at 1:33pm",
#                                  "from": "David Nester",
#                                  "dp": "assets/img/profiles/avatar.jpg",
#                                  "dpRetina": "assets/img/profiles/avatar2x.jpg"
#                              }, {
#                                  "id": 9,
#                                  "subject": "Aliquam est tellus, fringilla egestas fermentum quis",
#                                  "to": ["John Doe", "Anne Simons"],
#                                  "body": "<p> Donec metus ligula, cursus ut auctor ac, faucibus et eros. Mauris nec adipiscing purus, sollicitudin fermentum nunc. Nullam et elementum lectus. Duis lobortis commodo tellus quis rutrum. In sed interdum mauris. Vestibulum interdum dolor porta nisl faucibus, vitae convallis nisi hendrerit. Donec lacinia mauris nec erat elementum, adipiscing consectetur lorem egestas. Vivamus condimentum odio vel imperdiet sagittis. </p> ",
#                                  "time": "1:33pm",
#                                  "datetime" : "Today at 1:33pm",
#                                  "from": "David Nester",
#                                  "dp": "assets/img/profiles/avatar.jpg",
#                                  "dpRetina": "assets/img/profiles/avatar2x.jpg"
#                              }, {
#                                  "id": 10,
#                                  "subject": "Aliquam est tellus, fringilla egestas fermentum quis",
#                                  "to": ["John Doe", "Anne Simons"],
#                                  "body": "<p> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sodales, velit at laoreet hendrerit, tellus dui aliquet est, ac cursus velit erat et est. Quisque vitae tortor nibh. Aliquam ornare, augue ac pulvinar euismod, mi felis cursus nisl, non ultrices lacus turpis sit amet lacus. Vestibulum in lacus ut augue tincidunt lobortis id quis mauris. Morbi at fringilla lectus, non consectetur ante. Duis eleifend quis eros eu vulputate. Praesent sit amet dolor eros. Ut aliquam eros sed ante facilisis, ac venenatis diam feugiat.</p><p>Phasellus est massa, luctus eget volutpat id, semper nec elit. Nam ligula nunc, pharetra ac sodales porta, consectetur in est. Suspendisse mauris mauris, sagittis eu tristique ac, lacinia sed nisl. Nulla ut eros ac erat dignissim pellentesque sit amet ut tellus. Nunc at risus sed lacus commodo fringilla. Curabitur laoreet condimentum facilisis. Donec eget pellentesque massa. ",
#                                  "time": "1:33pm",
#                                  "datetime" : "Today at 1:33pm",
#                                  "from": "David Nester",
#                                  "dp": "assets/img/profiles/avatar.jpg",
#                                  "dpRetina": "assets/img/profiles/avatar2x.jpg"
#                              }]
#                 },{
#                     "group": "Yesterday April 22 ",
#                     "list": [{
#                                  "id": 11,
#                                  "subject": "Aliquam est tellus, fringilla egestas fermentum quis",
#                                  "to": ["John Doe", "Anne Simons"],
#                                  "body": "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sodales, velit at laoreet hendrerit, tellus dui aliquet est, ac cursus velit erat et est. Quisque vitae tortor nibh. Aliquam ornare, augue ac pulvinar euismod, mi felis cursus nisl, non ultrices lacus turpis sit amet lacus. Vestibulum in lacus ut augue tincidunt lobortis id quis mauris. Morbi at fringilla lectus, non consectetur ante. Duis eleifend quis eros eu vulputate. Praesent sit amet dolor eros. Ut aliquam eros sed ante facilisis, ac venenatis diam feugiat.</p><p>Phasellus est massa, luctus eget volutpat id, semper nec elit. Nam ligula nunc, pharetra ac sodales porta, consectetur in est. Suspendisse mauris mauris, sagittis eu tristique ac, lacinia sed nisl. Nulla ut eros ac erat dignissim pellentesque sit amet ut tellus. Nunc at risus sed lacus commodo fringilla. Curabitur laoreet condimentum facilisis. Donec eget pellentesque massa.</p> ",
#                                  "time": "1:33pm",
#                                  "datetime" : "Today at 1:33pm",
#                                  "from": "David Nester",
#                                  "dp": "assets/img/profiles/b.jpg",
#                                  "dpRetina": "assets/img/profiles/b2x.jpg"
#                              }, {
#                                  "id": 12,
#                                  "subject": "Aliquam est tellus, fringilla egestas fermentum quis",
#                                  "to": ["John Doe", "Anne Simons"],
#                                  "body": "<p>Aliquam est tellus, fringilla egestas fermentum quis, venenatis eu massa. Curabitur aliquet id metus a molestie. Phasellus porta, tellus id tempor condimentum, risus risus ullamcorper augue, in cursus libero enim sit amet purus. Vivamus nunc turpis, auctor quis consequat vitae, eleifend vitae risus. Vivamus vel facilisis lacus, nec semper felis. Aenean suscipit eget magna id ullamcorper. Ut dignissim in ligula eu accumsan. Donec tempus pretium leo aliquet pharetra. Etiam neque metus, varius non velit sit amet, consequat cursus dolor. Praesent leo odio, iaculis a quam at, venenatis adipiscing neque. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget nibh nec urna laoreet mollis. Nullam pharetra, tortor quis dignissim vulputate, ante elit viverra quam, nec congue diam tellus vel sem. Morbi aliquam tincidunt enim sit amet venenatis. Nulla ut est pharetra enim varius tempor.</p> ",
#                                  "time": "1:33pm",
#                                  "datetime" : "Today at 1:33pm",
#                                  "from": "David Nester",
#                                  "dp": "assets/img/profiles/avatar.jpg",
#                                  "dpRetina": "assets/img/profiles/avatar2x.jpg"
#                              }, {
#                                  "id": 13,
#                                  "subject": "Aliquam est tellus, fringilla egestas fermentum quis",
#                                  "to": ["John Doe", "Anne Simons"],
#                                  "body": "<p> Morbi mauris dui, sollicitudin ut ipsum nec, porta malesuada justo. In eget tempor lacus. In dapibus, mi id tempor mattis, orci dolor hendrerit mauris, a aliquam purus tellus id ipsum. Praesent id turpis metus. Mauris tempus nulla et magna euismod, pharetra sodales turpis sagittis. In ultricies erat turpis, sit amet venenatis elit malesuada eget. Quisque sodales ante mauris, eget tempus mauris molestie vel. In tristique augue sed quam dignissim, tempor facilisis neque malesuada. In sagittis placerat lectus, nec mattis felis aliquam eu. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vitae rutrum nibh. Maecenas scelerisque risus mauris, in ullamcorper nulla cursus ut. Integer a pharetra elit, vel pellentesque lectus. Ut erat tortor, euismod vel massa non, fringilla auctor neque.</p> ",
#                                  "time": "1:33pm",
#                                  "datetime" : "Today at 1:33pm",
#                                  "from": "David Nester",
#                                  "dp": "assets/img/profiles/avatar.jpg",
#                                  "dpRetina": "assets/img/profiles/avatar2x.jpg"
#                              }, {
#                                  "id": 14,
#                                  "subject": "Aliquam est tellus, fringilla egestas fermentum quis",
#                                  "to": ["John Doe", "Anne Simons"],
#                                  "body": "<p> Donec metus ligula, cursus ut auctor ac, faucibus et eros. Mauris nec adipiscing purus, sollicitudin fermentum nunc. Nullam et elementum lectus. Duis lobortis commodo tellus quis rutrum. In sed interdum mauris. Vestibulum interdum dolor porta nisl faucibus, vitae convallis nisi hendrerit. Donec lacinia mauris nec erat elementum, adipiscing consectetur lorem egestas. Vivamus condimentum odio vel imperdiet sagittis. </p> ",
#                                  "time": "1:33pm",
#                                  "datetime" : "Today at 1:33pm",
#                                  "from": "David Nester",
#                                  "dp": "assets/img/profiles/avatar.jpg",
#                                  "dpRetina": "assets/img/profiles/avatar2x.jpg"
#                              }, {
#                                  "id": 15,
#                                  "subject": "Aliquam est tellus, fringilla egestas fermentum quis",
#                                  "to": ["John Doe", "Anne Simons"],
#                                  "body": "<p> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sodales, velit at laoreet hendrerit, tellus dui aliquet est, ac cursus velit erat et est. Quisque vitae tortor nibh. Aliquam ornare, augue ac pulvinar euismod, mi felis cursus nisl, non ultrices lacus turpis sit amet lacus. Vestibulum in lacus ut augue tincidunt lobortis id quis mauris. Morbi at fringilla lectus, non consectetur ante. Duis eleifend quis eros eu vulputate. Praesent sit amet dolor eros. Ut aliquam eros sed ante facilisis, ac venenatis diam feugiat.</p><p>Phasellus est massa, luctus eget volutpat id, semper nec elit. Nam ligula nunc, pharetra ac sodales porta, consectetur in est. Suspendisse mauris mauris, sagittis eu tristique ac, lacinia sed nisl. Nulla ut eros ac erat dignissim pellentesque sit amet ut tellus. Nunc at risus sed lacus commodo fringilla. Curabitur laoreet condimentum facilisis. Donec eget pellentesque massa. ",
#                                  "time": "1:33pm",
#                                  "datetime" : "Today at 1:33pm",
#                                  "from": "David Nester",
#                                  "dp": "assets/img/profiles/avatar.jpg",
#                                  "dpRetina": "assets/img/profiles/avatar2x.jpg"
#                              }]
#                 }
#
#             ]
#             }