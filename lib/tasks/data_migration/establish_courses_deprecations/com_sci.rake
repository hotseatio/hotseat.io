# typed: strict
# frozen_string_literal: true

extend Rake::DSL # rubocop:disable Style/MixinUsage

namespace :data_migration do
  namespace :establish_course_deprecations do
    desc 'Establish the supercede/precede order for computer science courses'
    task computer_science: :environment do
      ActiveRecord::Base.transaction do
        # Computer Science
        subj_area = SubjectArea.find_by(code: 'COM SCI')
        courses = Course.where(subject_area: subj_area)

        # COM SCI 30
        cs97 = T.must courses.find_by(title: 'Variable Topics in Computer Science: Principles and Practices of Computing',
                                      number: '97')
        cs30 = T.must courses.find_by(number: '30')
        cs97.superseding_course = cs30
        cs97.save!

        # COM SCI 33
        systems_programming = T.must courses.find_by(title: 'Systems Programming',
                                                     number: '33')
        organization = T.must courses.find_by(title: 'Introduction to Computer Organization',
                                              number: '33')
        systems_programming.superseding_course = organization
        systems_programming.save!

        # COM SCI 35L
        # Software Construction Fundamentals
        fundamentals = T.must courses.find_by(title: 'Software Construction Fundamentals',
                                              number: '35')
        lab = T.must courses.find_by(title: 'Software Construction Laboratory',
                                     number: '35L')
        cs97 = T.must courses.find_by(title: 'Variable Topics in Computer Science: Software Construction Projects',
                                      number: '97')
        lecture = T.must courses.find_by(title: 'Software Construction',
                                         number: '35L')
        fundamentals.superseding_course = lab
        lab.superseding_course = cs97
        cs97.superseding_course = lecture
        fundamentals.save!
        lab.save!
        cs97.save!

        # COM SCI 112
        modeling_fundamentals = T.must courses.find_by(number: '112', title: 'Computer System Modeling Fundamentals')
        modeling_uncertainty = T.must courses.find_by(number: '112', title: 'Modeling Uncertainty in Information Systems')
        modeling_fundamentals.superseding_course = modeling_uncertainty
        modeling_fundamentals.save!

        # COM SCI 117
        csm117 = T.must courses.find_by(title: 'Computer Networks: Physical Layer',
                                        number: 'M117')
        cs117 = T.must courses.find_by(title: 'Computer Networks: Physical Layer',
                                       number: '117')
        csm117.superseding_course = cs117
        csm117.save!

        # COM SCI CM122
        systems_bio = T.must courses.find_by(title: 'Algorithms in Bioinformatics and Systems Biology',
                                             number: 'CM122')
        no_systems_bio = T.must courses.find_by(title: 'Algorithms in Bioinformatics',
                                                number: 'CM122')
        systems_bio.superseding_course = no_systems_bio
        systems_bio.save!

        # COM SCI CM124
        comp_genetics = T.must courses.find_by(title: 'Computational Genetics',
                                               number: 'CM124')
        ml_in_genetics = T.must courses.find_by(title: 'Machine Learning Applications in Genetics',
                                                number: 'CM124')
        comp_genetics.superseding_course = ml_in_genetics
        comp_genetics.save!

        # COM SCI 134
        special_courses_distributed_systems = T.must courses.find_by(title: 'Special Courses in Computer Science: Distributed Systems', number: '188')
        distributed_systems = T.must courses.find_by(title: 'Distributed Systems', number: '134')
        special_courses_distributed_systems.superseding_course = distributed_systems
        special_courses_distributed_systems.save!

        # COM SCI 143
        intro = T.must courses.find_by(title: 'Introduction to Database Systems',
                                       number: '143')
        no_intro = T.must courses.find_by(title: 'Database Systems',
                                          number: '143')
        intro.superseding_course = no_intro
        intro.save!

        # COM SCI M146
        special_courses_machine_learning = T.must courses.find_by(title: 'Special Courses in Computer Science: Introduction to Machine Learning', number: '188')
        machine_learning = T.must courses.find_by(title: 'Introduction to Machine Learning', number: 'M146')
        special_courses_machine_learning.superseding_course = machine_learning
        special_courses_machine_learning.save!

        # COM SCI M148
        special_courses_data_science = T.must courses.find_by(title: 'Special Courses in Computer Science: Data Science Fundamentals', number: '188')
        data_science = T.must courses.find_by(title: 'Introduction to Data Science', number: 'M148')
        special_courses_data_science.superseding_course = data_science
        special_courses_data_science.save!

        # COM SCI 152B
        m = T.must courses.find_by(title: 'Digital Design Project Laboratory',
                                   number: 'M152B')
        no_m = T.must courses.find_by(title: 'Digital Design Project Laboratory',
                                      number: '152B')
        m.superseding_course = no_m
        m.save!

        # COM SCI 170A
        sci_comp = T.must courses.find_by(title: 'Introduction to Scientific Computing',
                                          number: '170A')
        sci_comp_and_data_mining = T.must courses.find_by(title: 'Scientific Computing and Data Mining',
                                                          number: '170A')
        math_modeling = T.must courses.find_by(title: 'Mathematical Modeling and Methods for Computer Science',
                                               number: '170A')
        sci_comp.superseding_course = sci_comp_and_data_mining
        sci_comp_and_data_mining.superseding_course = math_modeling
        sci_comp.save!
        sci_comp_and_data_mining.save!

        # 171
        cs171l = T.must courses.find_by(number: '171L')
        csm171l = T.must courses.find_by(number: 'M171L')
        cs171l.superseding_course = csm171l
        cs171l.save!

        # 174
        cs174 = T.must courses.find_by(number: '174')
        cs174a = T.must courses.find_by(number: '174A')
        cs174.superseding_course = cs174a
        cs174.save!

        # COM SCI M182
        modeling = T.must courses.find_by(number: 'M182', title: 'Systems Biomodeling and Simulation Basics')
        dynamic_modeling = T.must courses.find_by(number: 'M182', title: 'Dynamic Biosystem Modeling and Simulation Methodology')
        modeling.superseding_course = dynamic_modeling
        modeling.save!

        # 187
        research_workshop = T.must courses.find_by(number: 'CM186C', title: 'Biomodeling Research and Research Communication Workshop')
        thesis_research_186c = T.must courses.find_by(number: 'CM186C', title: 'Thesis Research and Research Communication in Computational and Systems Biology')
        thesis_research187 = T.must courses.find_by(number: 'CM187', title: 'Thesis Research and Research Communication in Computational and Systems Biology')
        research_communication = T.must courses.find_by(number: 'CM187', title: 'Research Communication in Computational and Systems Biology')
        research_workshop.superseding_course = thesis_research_186c
        thesis_research_186c.superseding_course = thesis_research187
        thesis_research187.superseding_course = research_communication
        research_workshop.save!
        thesis_research_186c.save!
        thesis_research187.save!

        # COM SCI 192
        la_pedagogy = T.must courses.find_by(number: '192A', title: 'Learning Assistant Pedagogy')
        la_no_m = T.must courses.find_by(number: '192A', title: 'Introduction to Collaborative Learning Theory and Practice')
        la_m = T.must courses.find_by(number: 'M192A', title: 'Introduction to Collaborative Learning Theory and Practice')
        la_pedagogy.superseding_course = la_no_m
        la_no_m.superseding_course = la_m
        la_pedagogy.save!
        la_no_m.save!

        # COM SCI 186/196
        # 196A
        cs_196a = T.must courses.find_by(title: 'Introduction to Bioengineering and Cybernetics', number: '196A')
        cs_m196a = T.must courses.find_by(title: 'Introduction to Cybernetics, Biomodeling, and Biomedical Computing', number: 'M196A')
        cs_m186a = T.must courses.find_by(title: 'Introduction to Cybernetics, Biomodeling, and Biomedical Computing', number: 'M186A')
        cs_m186a_new = T.must courses.find_by(title: 'Introduction to Computational and Systems Biology', number: 'M186A')
        cs_m184 = T.must courses.find_by(title: 'Introduction to Computational and Systems Biology', number: 'M184')
        cs_196a.superseding_course = cs_m196a
        cs_m196a.superseding_course = cs_m186a
        cs_m186a.superseding_course = cs_m186a_new
        cs_m186a_new.superseding_course = cs_m184
        cs_196a.save!
        cs_m196a.save!
        cs_m186a.save!
        cs_m186a_new.save!

        # 196B
        cs_196b = T.must courses.find_by(title: 'Modeling and Simulation of Biological Systems', number: 'M196B')
        cs_comp_systems_prefix_196b = T.must courses.find_by(title: 'Computational Systems Biology: Modeling and Simulation of Biological Systems', number: 'M196B')
        cs_m186b = T.must courses.find_by(title: 'Computational Systems Biology: Modeling and Simulation of Biological Systems', number: 'M186B')
        cs_cm186b = T.must courses.find_by(title: 'Computational Systems Biology: Modeling and Simulation of Biological Systems', number: 'CM186B')
        cs_cm186 = T.must courses.find_by(title: 'Computational Systems Biology: Modeling and Simulation of Biological Systems', number: 'CM186')
        cs_196b.superseding_course = cs_comp_systems_prefix_196b
        cs_comp_systems_prefix_196b.superseding_course = cs_m186b
        cs_m186b.superseding_course = cs_cm186b
        cs_cm186b.superseding_course = cs_cm186
        cs_196b.save!
        cs_comp_systems_prefix_196b.save!
        cs_m186b.save!
        cs_cm186b.save!

        # COM SCI M213B
        cs213 = T.must courses.find_by(number: '213')
        cs_m213b = T.must courses.find_by(number: 'M213B')
        cs213.superseding_course = cs_m213b
        cs213.save!

        # COM SCI M222
        systems_bio = T.must courses.find_by(title: 'Algorithms in Bioinformatics and Systems Biology',
                                             number: 'CM222')
        no_systems_bio = T.must courses.find_by(title: 'Algorithms in Bioinformatics',
                                                number: 'CM222')
        systems_bio.superseding_course = no_systems_bio
        systems_bio.save!

        # COM SCI CM224
        comp_genetics = T.must courses.find_by(title: 'Computational Genetics',
                                               number: 'CM224')
        ml_in_genetics = T.must courses.find_by(title: 'Machine Learning Applications in Genetics',
                                                number: 'CM224')
        comp_genetics.superseding_course = ml_in_genetics
        comp_genetics.save!

        # COM SCI M296A
        modeling_methodologies = T.must courses.find_by(number: 'M296A', title: 'Modeling Methodology for Biomedical Systems')
        advanced_modeling_methodologies = T.must courses.find_by(number: 'M296A', title: 'Advanced Modeling Methodology for Dynamic Biomedical Systems')
        modeling_methodologies.superseding_course = advanced_modeling_methodologies
        modeling_methodologies.save!
      end
    end
  end
end
