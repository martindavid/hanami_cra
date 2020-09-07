module Api
  module Controllers
    module Health
      class Index
        include Api::Action

        def call(params)
          self.body = {:msg => 'Success'}
        end
      end
    end
  end
end
