# typed: strict
# frozen_string_literal: true

extend Rake::DSL # rubocop:disable Style/MixinUsage

namespace :data_migration do
  namespace :establish_course_deprecations do
    desc 'Establish the supercede/precede order for linguistics courses'
    task linguistics: :environment do
      ActiveRecord::Base.transaction do
        # Computer Science
        ling = SubjectArea.find_by(code: 'LING')
        courses = Course.where(subject_area: ling)

        # Ling 10
        eng_words_no_m = T.must(courses.find_by(number: '10'))
        eng_words_m = T.must(courses.find_by(number: 'M10'))
        eng_words_no_m.superseding_course = eng_words_m
        eng_words_no_m.save!

        # Ling 19: Klingon
        klingon_old = T.must(courses.find_by(number: '19', title: 'Klingon Language and Linguistics'))
        klingon_new = T.must(courses.find_by(number: '19', title: 'Klingon'))
        klingon_old.superseding_course = klingon_new
        klingon_old.save!

        # Ling 20
        intro_ling_old = T.must(courses.find_by(number: '20', title: 'Introduction to Linguistics'))
        intro_ling_new = T.must(courses.find_by(number: '20', title: 'Introduction to Linguistic Analysis'))
        intro_ling_old.superseding_course = intro_ling_new
        intro_ling_old.save!

        # 111
        intonation_c = T.must(courses.find_by(number: 'C111'))
        intonation_no_c = T.must(courses.find_by(number: '111'))
        intonation_c.superseding_course = intonation_no_c
        intonation_c.save!

        # 114
        indigenous = T.must(courses.find_by(number: '114', title: 'American Indigenous Linguistics'))
        indian = T.must(courses.find_by(number: '114', title: 'American Indian Linguistics'))
        indian.superseding_course = indigenous
        indian.save!

        # 119A
        structures = T.must(courses.find_by(number: '119A', title: 'Phonological Structures'))
        applied = T.must(courses.find_by(number: '119A', title: 'Applied Phonology'))
        structures.superseding_course = applied
        structures.save!

        # 130
        lang_dev_c = T.must(courses.find_by(number: 'C130'))
        lang_dev_no_c = T.must(courses.find_by(number: '130'))
        lang_dev_c.superseding_course = lang_dev_no_c
        lang_dev_c.save!

        # 132
        lang_processing_c = T.must(courses.find_by(number: 'C132'))
        lang_processing_no_c = T.must(courses.find_by(number: '132'))
        lang_processing_c.superseding_course = lang_processing_no_c
        lang_processing_c.save!

        # 140
        bilingualism_no_c = T.must(courses.find_by(number: '140'))
        bilingualism_c = T.must(courses.find_by(number: 'C140'))
        bilingualism_no_c.superseding_course = bilingualism_c
        bilingualism_no_c.save!

        # 144
        translation_m = T.must(courses.find_by(number: 'M144'))
        translation_no_m = T.must(courses.find_by(number: '144'))
        translation_m.superseding_course = translation_no_m
        translation_m.save!

        # 170
        sociolinguistics_no_m = T.must(courses.find_by(number: '170'))
        sociolinguistics_m = T.must(courses.find_by(number: 'M170'))
        sociolinguistics_no_m.superseding_course = sociolinguistics_m
        sociolinguistics_no_m.save!

        # M176B
        structure_ii = T.must(courses.find_by(number: 'M176B', title: 'Structure of Japanese II'))
        structure = T.must(courses.find_by(number: 'M176B', title: 'Structure of Japanese'))
        structure_ii.superseding_course = structure
        structure_ii.save!

        # 180
        math_ling = T.must(courses.find_by(number: 'C180', title: 'Mathematical Linguistics I'))
        math_structs_c =  T.must(courses.find_by(number: 'C180', title: 'Mathematical Structures in Language I'))
        math_structs_no_c = T.must(courses.find_by(number: '180', title: 'Mathematical Structures in Language I'))
        math_ling.superseding_course = math_structs_c
        math_structs_c.superseding_course = math_structs_no_c
        math_ling.save!
        math_structs_c.save!

        # 185A
        comp_ling_i_c = T.must(courses.find_by(number: 'C185A'))
        comp_ling_i_no_c = T.must(courses.find_by(number: '185A'))
        comp_ling_i_c.superseding_course = comp_ling_i_no_c
        comp_ling_i_c.save!

        # 185B
        comp_ling_ii_c = T.must(courses.find_by(number: 'C185B'))
        comp_ling_ii_no_c = T.must(courses.find_by(number: '185B'))
        comp_ling_ii_c.superseding_course = comp_ling_ii_no_c
        comp_ling_ii_c.save!
      end
    end
  end
end
