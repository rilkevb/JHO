class UserSerializer < ActiveModel::Serializer
  attributes :name, :auth_token, :id
end
