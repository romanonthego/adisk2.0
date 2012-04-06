class App.User extends Spine.Model
  @configure 'User', 'email', 'password', 'password_confirmation'
  @extend Spine.Model.Ajax