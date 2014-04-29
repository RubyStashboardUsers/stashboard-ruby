require 'stashboard'

describe Stashboard::Stashboard do
  puts "Initial Setup"
  stashboard = Stashboard::Stashboard.new("https://stashboard-rubytest.appspot.com", "1/AE5l7QIvbL1hgg3oziydZd0pRecbDDf5488kuM4bxaA", "Gm6ACEeTitym9OBluOJ50vYo")
  ids = stashboard.service_ids

  puts "Resetting statuses..."
  ids.each do |id|
    puts "  • #{id}"
    stashboard.create_event(id, "up", "Setting #{id} to up for testing purposes.")
  end

  puts "\nRunning tests..."

  id = ids[0]

  it "Has reset all" do
    service = stashboard.service(id)
    service["current-event"]["status"]["id"].should eql("up")
  end

  it "Can update status" do
    stashboard.create_event(id, "down", "Setting #{id} to down for testing purposes.")

    service = stashboard.service(id)
    service["current-event"]["status"]["id"].should eql("down")
  end

  it "Can mass-asign" do
    ids.each do |id|
      stashboard.create_event(id, "warning", "Setting #{id} to warning for testing purposes.")

      service = stashboard.service(id)
      service["current-event"]["status"]["id"].should eql("warning")
    end
  end
end