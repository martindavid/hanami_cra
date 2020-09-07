module Api
  module Controllers
    module Authors
      class List
        include Api::Action
        accept :json

        def initialize(repository = AuthorRepository.new)
          @repository = repository
        end

        def call(params)
          authors = @repository.all
          self.body = authors.map{|a| a.to_h }.to_json
        end
      end
    end
  end
end
