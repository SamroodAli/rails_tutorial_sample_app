require "test_helper"

class RelationshipTest < ActiveSupport::TestCase

  def setup
    @relationship = Relationship.new(
      follower_id:users(:samrood).id,
      followed_id:users(:micheal).id
    )

    


  end
end
