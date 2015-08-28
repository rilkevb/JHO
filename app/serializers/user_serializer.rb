class UserSerializer < ActiveModel::Serializer
  attributes :name, :token, :id
end
