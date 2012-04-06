class App.Users extends Spine.Controller
  # elements:
  #   '.items': items
  # 
  # events:
  #   'click .item': 'itemClick'

  constructor: ->
    super
    # ...

# class App.Movies extends Spine.Stack
#   controllers:
#     index: Index
#     edit:  Edit
#     show:  Show
#     new:   New
    
#   routes:
#     '/movies/new':      'new'
#     '/movies/:id/edit': 'edit'
#     '/movies/:id':      'show'
#     '/movies':          'index'
    
#   default: 'index'
#   className: 'stack movies'