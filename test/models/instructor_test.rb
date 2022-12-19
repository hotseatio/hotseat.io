# typed: strict
# frozen_string_literal: true

require 'test_helper'

class InstructorTest < ActiveSupport::TestCase
  describe '#full_label' do
    describe 'with first and last names' do
      it "combines an instructor's first and last names" do
        instructor = build(:instructor, first_names: ['Paul'], last_names: ['Eggert'])
        assert_equal('Paul Eggert', instructor.full_label)
      end

      it 'can handle two people as one instructor' do
        instructor = build(:instructor, first_names: ['Paul', 'David A.'], last_names: %w[Eggert Smallberg])
        assert_equal('Paul Eggert and David A. Smallberg', instructor.full_label)
      end

      it 'can handle three people as one instructor' do
        instructor = build(:instructor, first_names: ['Paul', 'David A.', 'Jens'], last_names: %w[Eggert Smallberg Palsberg])
        assert_equal('Paul Eggert et al.', instructor.full_label)
      end
    end

    describe 'with registrar listing only' do
      it 'gives the registrar list if there is one' do
        instructor = build(:instructor, registrar_listing: ['Eggert, P.R.'])
        assert_equal('Eggert, P.R.', instructor.full_label)
      end

      it 'can handle two-person listings' do
        instructor = build(:instructor, registrar_listing: ['Eggert, P.R.', 'Smallberg, D.'])
        assert_equal('Eggert, P.R. and Smallberg, D.', instructor.full_label)
      end

      it 'can handle three-person listings' do
        instructor = build(:instructor, registrar_listing: ['Eggert, P.R.', 'Smallberg, D.', 'Palsberg, J.'])
        assert_equal('Eggert, P.R. et al.', instructor.full_label)
      end
    end
  end
end
