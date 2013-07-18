class SignageController < ApplicationController
  layout "signage"
  
  def view 
    @building = Building.where(:code => params[:building]).first
    return not_found if @building.nil?

    @current_usages = @building.current_bookings
    @upcoming_usages = @building.upcoming_bookings

    @empty_rooms = Room.where(:building_id => @building)
    .joins('LEFT OUTER JOIN room_bookings ON room_bookings.room_id = rooms.id AND now() BETWEEN room_bookings
.starts_at AND room_bookings.ends_at').where('room_bookings.id IS NULL')

    puts @empty_rooms.explain
  end
end