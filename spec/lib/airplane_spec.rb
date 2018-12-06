require_relative '../../lib/airplane'

describe Airplane do
  let(:my_plane) { Airplane.new('cesna', 10, 150) }
  let(:no_fuel) { Airplane.new('cesna', 10, 150, 0) }
  let(:low_fuel) { Airplane.new('cesna', 10, 150, 20) }
  describe '.new' do
    context 'takes 3 arguments to build a plane' do
      it 'should have a type, wing loading, and horsepower' do
        expect(my_plane).to be_a(Airplane)
        expect(my_plane.type).to eq('cesna')
        expect(my_plane.wing_loading).to eq(10)
        expect(my_plane.horsepower).to eq(150)
        expect(my_plane.fuel).to eq(1000)
      end
    end
  end

  describe '#start' do
    context 'if it hasnt started' do
      it 'starts the plane' do
        expect(my_plane.start).to eq('Airplane started')
      end
    end
    context 'if it has started' do
      it 'tells us its already started' do
        my_plane.start
        expect(my_plane.start).to eq('Airplane already started')
      end
    end
    context 'if it has not enough fuel' do
      it 'tells us it needs more fuel' do
        expect(no_fuel.start).to eq('Airplane needs more fuel to start')
      end
    end
  end

  describe '#takeoff' do
    context 'if it hasnt taken off and it hasnt started' do
      it 'should say not started' do
        expect(my_plane.takeoff).to eq('Airplane not started, please start')
      end
    end
    context 'if it hasnt taken off and it has started' do
      it 'should say it launched' do
        my_plane.start
        expect(my_plane.takeoff).to eq('Airplane launched')
      end
    end
    context 'if it has already taken off' do
      it 'should say its in the air' do
        my_plane.start
        my_plane.takeoff
        expect(my_plane.takeoff).to eq('Airplane in the air already')
      end
    end
    context 'if it doesnt have enough fuel' do
      it 'should say theres not enough' do
        low_fuel.start
        expect(low_fuel.takeoff).to eq('Not enough fuel to take off')
      end
    end
  end

  describe '#land' do
    context 'if the plane isnt started' do
      it 'says the plane isnt started please start' do
        expect(my_plane.land).to eq('Airplane not started, please start')
      end
    end
    context 'if the plane is not in the air' do
      it 'should say its already landed' do
        my_plane.start
        expect(my_plane.land).to eq('Airplane already on the ground')
      end
    end
    context 'if the plane is in the air' do
      it 'should say it landed' do
        my_plane.start
        my_plane.takeoff
        expect(my_plane.land).to eq('Airplane landed')
      end
    end
  end

  describe '#miles_left' do
    it 'reports how many miles more it can travel on the fuel (5mpg)' do
      expect(my_plane.miles_left).to eq(5000)
    end
  end

  describe '#flyto' do
    context 'will tell the user not enough fuel if' do
      it 'distance/5 + 10 >= fuel' do
        my_plane.start
        my_plane.takeoff
        expect(my_plane.flyto(5000)).to eq('Not enough fuel to make it')
        expect(my_plane.flyto(4845)).to eq('Not enough fuel to make it')
      end
    end
    context 'will tell the user it can fly the distance' do
      it 'distance/5 + 10 < fuel' do
        my_plane.start
        my_plane.takeoff
        expect(my_plane.flyto(500)).to eq('The airplane made the distance')
        my_plane.land
        expect(my_plane.fuel).to eq(869)
      end
    end
  end
end
