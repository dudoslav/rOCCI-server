require 'backends/dummy/entity_base'

module Backends
  module Dummy
    class Securitygrouplink < EntityBase
      class << self
        # @see `served_class` on `Entitylike`
        def served_class
          Occi::InfrastructureExt::SecurityGroupLink
        end

        # :nodoc:
        def entity_identifier
          Occi::InfrastructureExt::Constants::SECURITY_GROUP_LINK_KIND
        end
      end

      # @see `Entitylike`
      def instance(identifier)
        instance = super
        instance['occi.core.source'] = URI.parse '/compute/a262ad95-c093-4814-8c0d-bc6d475bb845'
        instance['occi.core.target'] = URI.parse '/securitygroup/8b3e4362-b761-4eed-a6f3-69e271f90286'
        instance.target_kind = category_by_identifier!(
          Occi::InfrastructureExt::Constants::SECURITY_GROUP_KIND
        )
        instance
      end
    end
  end
end
