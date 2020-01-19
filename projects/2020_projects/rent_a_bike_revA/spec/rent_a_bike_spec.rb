require "spec_helper"
require "./lib/rent_a_bike.rb"

describe DockingStation do 
    
    it { is_expected.to respond_to(:release_bike) }
    it { is_expected.to respond_to(:dock_bike).with(1).argument }
    it { is_expected.to respond_to(:bikes) }
  
    describe 'initialization' do

        it 'has a default capacity' do
            expect(subject.capacity).to eq(DockingStation::DEFAULT_DOCK_CAPACITY)
        end

        it 'has an adjustable capacity' do
            test_dock = DockingStation.new(10)
            expect(test_dock.capacity).to eq(10)
        end
    end

    describe '#release_bike' do
        
        it 'releases working bike when available' do
            test_bike = double(:bike, working?: true)
            subject.dock_bike(test_bike)
            expect(subject.release_bike).to eq test_bike
        end

        it 'skips broken bikes' do 
            test_bikes = [double(:bike, working?: true), double(:bike, working?: false), double(:bike, working?: false), double(:bike, working?: true)] 
            test_bikes.each {|x| subject.dock_bike(x)}
            test_working_array = []

            2.times do
                test_working_array.push((subject.release_bike).working?)
            end

            expect(test_working_array).to all(be true)
        end

        it 'raises exception when only broken bikes available' do
            subject.dock_bike(double(:bike, working?: false)) 
            expect{subject.release_bike}.to raise_error 'No Working Bikes Available'
        end

        it 'raises exception when the dock is empty' do
            expect{subject.release_bike}.to raise_error 'Docking Station Empty'
        end  
    end

    describe '#dock_bike' do
        
        it 'docks bike' do
            test_dock_bike = double(:bike, working?: true)
            expect(subject.dock_bike(test_dock_bike)).to include(test_dock_bike)
        end

        it 'fails when number of docked bikes exceedes default capacity' do
            subject.capacity.times { subject.dock_bike(double(:bike)) }
            expect{ subject.dock_bike(double(:bike)) }.to raise_error 'Docking Station Full' 
        end

        it 'assigns docked bikes to an array' do
            test_docked_bike = double(:bike, working?: true) 
            test_docked_bike_2 = double(:bike, working?: true)
            subject.dock_bike(test_docked_bike)
            subject.dock_bike(test_docked_bike_2)
            expect(subject.bikes).to include test_docked_bike && test_docked_bike_2
        end 
    end

    describe '#release_bikes_for_repair' do 
        
        it 'releases broken bikes when available' do
            broken_bike = double(:bike, working?: false)
            subject.dock_bike(broken_bike)
            expect(subject.release_bikes_for_repair).to eq [broken_bike]
        end

        it 'skips working bikes' do 
            test_bikes_2 = [double(:bike, working?: true), double(:bike2, working?: false), double(:bike3, working?: false), double(:bike4, working?: true)] 
            test_bikes_2.each {|x| subject.dock_bike(x)}
            puts subject.bikes
            test = subject.release_bikes_for_repair
            
            test_broken_array = []
            test.each{ |x| test_broken_array.push(x.working?)}
            expect(test_broken_array).to all(be false)
        end

        it 'raises exception when only working bikes available' do
            subject.dock_bike(double(:bike, working?: true))
            expect{subject.release_bikes_for_repair}.to raise_error 'No Broken Bikes Available'
        end

        it 'raises exception when the dock is empty' do
            expect{subject.release_bikes_for_repair}.to raise_error 'Docking Station Empty'
        end  
    end
end

describe Bike do 
   
    it { is_expected.to respond_to :working? }  
    it { is_expected.to respond_to :condition }  

    describe 'initialization' do
        it 'has a default working condition' do
            expect(subject.condition).to eq(Bike::DEFAULT_CONDITION)
        end
    end

    describe '#working?' do
        
        it 'is working by default' do
            expect(subject).to be_working
        end

        it 'returns false for broken bike' do
            subject = Bike.new('broken')
            expect(subject).not_to be_working
        end
    end

    describe '#assign_condition()' do

        it 'assigns a new condition to the bike' do
            subject = Bike.new('broken')
            subject.assign_condition('working')
            expect(subject).to be_working
        end
    end

end


describe User do

    subject = User.new('Default Username')

    describe 'initialization' do
        
        it 'has a username' do 
            expect(subject.username).to eq('Default Username')
        end

        it 'has a default capacity' do
            expect(subject.capacity).to eq(User::DEFAULT_USER_CAPACITY)
        end
    end


    describe '#hire_bike' do
        
        it 'user accepts released bike from dock' do
            test_bike_3 = double(:bike, working?: true) 
            test_dock_2 = double(:dock, release_bike: test_bike_3)
            subject.hire_bike(test_dock_2)
            expect(subject.bikes).to eq([test_bike_3]) # here I am testing that the hire bike method requests a bike from a specific dock and assigns the released bike to the user_bikes array
        end
    end

    describe '#return_bike' do
        
        it 'user returns bike to dock' do
            test_bike_4 = double(:bike, working?: true) 
            test_dock_3 = double(:dock, release_bike: test_bike_4)
            expect(test_dock_3).to receive(:dock_bike).with(test_bike_4)  # tests that the return_bike method call dock_bike for the given dock with the rented bike as an argument
            subject.hire_bike(test_dock_3)
            subject.return_bike(test_dock_3)
        end

        it 'raises exception when the user does not have a bike to return' do
            expect{User.new('Greg)').return_bike(double(:dock))}.to raise_error 'No Bikes Currently Under Hire' 
        end  
    end
end

describe Maintenance do

    it { is_expected.to respond_to(:bikes) }

    describe 'initialisation' do

        it 'has a default capacity' do
            expect(subject.capacity).to eq(Maintenance::DEFAULT_MAINTENANCE_CAPACITY)
        end
        
    end
    
    describe '#retrieve_broken_bikes' do
        
        it 'retrieves broken bikes from dock' do
            test_bike_4 = double(:bike, working?: false) 
            test_dock_3 = double(:dock, release_bikes_for_repair: [test_bike_4])
            subject.retrieve_broken_bikes(test_dock_3)
            expect(subject.bikes).to eq([test_bike_4])
        end
    end

    describe '#repair_bikes' do
       
        it 'initates the bike repair' do
            test_bike_5 = double(:bike, working?: false) 
            test_dock_4 = double(:dock, release_bikes_for_repair: [test_bike_5])
            subject.retrieve_broken_bikes(test_dock_4)
            expect(test_bike_5).to receive(:assign_condition).with('working')
            subject.repair_bikes
        end
    end

    describe '#return_working_bikes' do
        
        it 'maintenance returns only working bikes to dock' do
            test_bike_6 =  double(:bike6, working?: false)
            test_bike_7 = double(:bike7, working?: true)
            test_dock_5 = double(:dock)
            subject.bikes = [test_bike_6, test_bike_7]
            expect(test_dock_5).to receive(:dock_bike).with(test_bike_7) # this test works in this very basic example but can't cope with a more complex @bikes array - I would like to update the test to account for the looped dock_bike calls.
            subject.return_working_bikes(test_dock_5)
        end
     
        it 'raises exception when maintenance does not have a bike to return' do
            expect{Maintenance.new.return_working_bikes(double(:dock))}.to raise_error 'No Bikes Currently Out For Maintenance' 
        end  
    end
end

=begin
    
    it 'raises exception when docking station full' do
            test_bike_2 = Bike.new
            subject.dock_bike(test_bike_2)
            expect{subject.dock_bike(test_bike_2)}.to raise_error 'Docking Station Full'
    end
    
    it 'skips broken bikes' do
        test_bike_broken = Bike.new('Flat Tyre')
        test_bike_working = Bike.new
        subject.dock_bike(test_bike_broken)
        subject.dock_bike(test_bike_working)
        expect(subject.release_bike).to eq test_bike_working
    end
=end