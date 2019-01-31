module Api
  module BaseHelpers
    def declared_params
      declared(params, include_missing: false)
    end

    def present_with_entities(object)
      if object.try(:count)
        return present object, with: object.first.serializer_clazz
      end
      present object, with: object.serializer_clazz
    end
  end
end
