class ClacbtUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :role, :created_at, :updated_at
end
