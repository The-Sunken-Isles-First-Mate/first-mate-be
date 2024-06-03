class UserSerializer
  include JSONAPI::Serializer
  attributes :uid, :username, :token
end
