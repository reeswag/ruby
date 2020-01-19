require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class UserData
    include DataMapper::Resource
    property :id, Serial
    property :username, String
    property :bike_count, Integer, :default => 0
    property :capacity, Integer, :default => 1

    def access_user_bikes
        @user=self.username
        @bikes = Bikes.all(:assigned_to => @user)
        if @bikes.empty?
            self.update(:bike_count => 0)
        else
            self.update(:bike_count => @bikes.count)
        end
        return @bikes
    end
end

class Bikes
    include DataMapper::Resource
    property :id, Serial
    property :assigned_to, String
    property :condition, String, :default => "working"

    def working?
        if self.condition == "working"
            return true
        else
            return false
        end
    end

    def assign_condition(new_condition) 
        self.update(:condition => new_condition)
    end
end

def rent_a_bike_initialiser
    unless (UserData.all).empty? && (Bikes.all).empty?
        fail 'Data Already Exists'
    else
        20.times do
            Bikes.create(assigned_to: "DOCKINGSTATION")
        end
        UserData.create(username: "DOCKINGSTATION", capacity: 20, bike_count:20)
        UserData.create(username: "MAINTENANCE", capacity: 20, bike_count:0)
        p UserData.all
    end
end

def factory_reset
    UserData.destroy
    Bikes.destroy
end

def release_bike(username, dock = "DOCKINGSTATION")
    @bikes = Bikes.all(:assigned_to => dock)
    if @bikes.empty?
        fail 'Docking Station Empty'
    elsif @bikes.any? {|x| x.working?} == false
        fail 'No Working Bikes Available'
    else
        (@bikes.last).update(:assigned_to => username)
    end
end

def release_bikes_for_repair( username = "MAINTENANCE", dock = "DOCKINGSTATION")
    @bikes = Bikes.all(:assigned_to => dock) - Bikes.all(:condition => "working")
    if @bikes.empty?
        fail 'No Broken Bikes Available'
    else
        (@bikes.all).update(:assigned_to => username)
    end
end

def repair_bikes(username = "MAINTENANCE")
    @bikes = Bikes.all(:assigned_to => username) - Bikes.all(:condition => "working")
    if @bikes.empty?
        fail 'No Broken Bikes Out For Repair!'
    else
        (@bikes.all).update(:condition => "working")
    end
end

def return_bike(username, bike = nil, dock = "DOCKINGSTATION")
    @bikes = Bikes.all(:assigned_to => username)
    if @bikes.empty?
        fail 'No Bikes Currently Under Hire'
    elsif bike == nil
        (@bikes.last).update(:assigned_to => dock)
    else
        (@bikes[bike]).update(:assigned_to => dock)
    end
end

def return_working_bikes(username = "MAINTENANCE", dock = "DOCKINGSTATION")
    @bikes = Bikes.all(:assigned_to => username, :condition => "working")
    if @bikes.empty?
        fail 'No Bikes Ready To Return!'
    else
        @bikes.update(:assigned_to => dock)
    end
end

DataMapper.finalize