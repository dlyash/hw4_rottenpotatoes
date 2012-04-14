require 'spec_helper'

describe MoviesController do
	before(:each) do
		@thisMovie = mock("thisMovie", :id => "1", :director => "director")
	end

	describe 'Searching for similar movies' do
		it 'should call model for similar movies' do
			Movie.should_receive(:find).with(@thisMovie.id).and_return(@thisMovie)
			Movie.should_receive(:find_all_by_director).with(@thisMovie.director)
			
			get :similar, :id => @thisMovie.id
		end
		
		it 'should show results page, if any similar movies found' do
			Movie.stub(:find).with(@thisMovie.id).and_return(@thisMovie)
			Movie.stub(:find_all_by_director)
			
			get :similar, :id => @thisMovie.id
			
			response.should render_template('similar')
		end
		
		it 'should make current movie available to the view' do
			Movie.stub(:find).with(@thisMovie.id).and_return(@thisMovie)
			Movie.stub(:find_all_by_director).with(@thisMovie.director).and_return("fake")
			
			get :similar, :id => @thisMovie.id
			
			assigns(:movie).should == @thisMovie
		end		
		
		it 'should make result list available to the view' do
			Movie.stub(:find).with(@thisMovie.id).and_return(@thisMovie)
			Movie.stub(:find_all_by_director).with(@thisMovie.director).and_return("fake")
			
			get :similar, :id => @thisMovie.id
			
			assigns(:movies).should == "fake"
		end
	end
end
