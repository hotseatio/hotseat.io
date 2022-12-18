# typed: strict
# frozen_string_literal: true

extend Rake::DSL # rubocop:disable Style/MixinUsage

namespace :data_migration do
  desc 'Establish the supercede/precede order for subject areas'
  task establish_subject_area_deprecations: :environment do
    ActiveRecord::Base.transaction do
      # African Studies
      afr_std = T.must(SubjectArea.find_by(code: 'AFR STD'))
      af_stds = T.must(SubjectArea.find_by(code: 'AF STDS'))
      afrc_st = T.must(SubjectArea.find_by(code: 'AFRC ST'))
      afr_std.superseding_subject_area = af_stds
      af_stds.superseding_subject_area = afrc_st
      afr_std.save!
      af_stds.save!

      # African Languages
      african = T.must(SubjectArea.find_by(code: 'AFRICAN'))
      af_lang = T.must(SubjectArea.find_by(code: 'AF LANG'))
      african.superseding_subject_area = af_lang
      african.save!

      # Applied Linguistics
      ap_ling = T.must(SubjectArea.find_by(code: 'AP LING'))
      appling = T.must(SubjectArea.find_by(code: 'APPLING'))
      ap_ling.superseding_subject_area = appling
      ap_ling.save!

      # Atmospheric and Oceanic Sciences
      atmosci = T.must(SubjectArea.find_by(code: 'ATMOSCI'))
      ao_sci = T.must(SubjectArea.find_by(code: 'A&O SCI'))
      atmosci.superseding_subject_area = ao_sci
      atmosci.save!

      # Bulgarian
      bulgar = T.must(SubjectArea.find_by(code: 'BULGAR'))
      bulgr = T.must(SubjectArea.find_by(code: 'BULGR'))
      bulgar.superseding_subject_area = bulgr
      bulgar.save!

      # Central and East European Studies
      cee_std = T.must(SubjectArea.find_by(code: 'CEE STD'))
      cee_st = T.must(SubjectArea.find_by(code: 'C&EE ST'))
      cee_std.superseding_subject_area = cee_st
      cee_std.save!

      # Chemical Engineering
      chm_eng = T.must(SubjectArea.find_by(code: 'CHM ENG'))
      ch_engr = T.must(SubjectArea.find_by(code: 'CH ENGR'))
      chm_eng.superseding_subject_area = ch_engr
      chm_eng.save!

      # Chicana/o and Central American Studies
      chicano = T.must(SubjectArea.find_by(code: 'CHICANO'))
      ccas = T.must(SubjectArea.find_by(code: 'CCAS'))
      chicano.superseding_subject_area = ccas
      chicano.save!

      # Chinese
      chinese = T.must(SubjectArea.find_by(code: 'CHINESE'))
      chin = T.must(SubjectArea.find_by(code: 'CHIN'))
      chinese.superseding_subject_area = chin
      chinese.save!

      # Communication
      com_std = T.must(SubjectArea.find_by(code: 'COM STD'))
      comm_st = T.must(SubjectArea.find_by(code: 'COMM ST'))
      comm = T.must(SubjectArea.find_by(code: 'COMM'))
      com_std.superseding_subject_area = comm_st
      comm_st.superseding_subject_area = comm
      com_std.save!
      comm_st.save!

      # Czech
      czech = T.must(SubjectArea.find_by(code: 'CZECH'))
      czch = T.must(SubjectArea.find_by(code: 'CZCH'))
      czech.superseding_subject_area = czch
      czech.save!

      # DESMA
      design = T.must(SubjectArea.find_by(code: 'DESIGN'))
      desma = T.must(SubjectArea.find_by(code: 'DESMA'))
      design.superseding_subject_area = desma
      design.save!

      # Earth, Planetary, and Space Sciences
      es_sci = T.must(SubjectArea.find_by(code: 'E&S SCI'))
      eps_sci = T.must(SubjectArea.find_by(code: 'EPS SCI'))
      es_sci.superseding_subject_area = eps_sci
      es_sci.save!

      # East Asian Studies
      #
      # Electrical and Computer Engineering
      el_engr = T.must(SubjectArea.find_by(code: 'EL ENGR'))
      ec_engr = T.must(SubjectArea.find_by(code: 'EC ENGR'))
      el_engr.superseding_subject_area = ec_engr
      el_engr.save!

      # Ethnomusicology
      ethnomu = T.must(SubjectArea.find_by(code: 'ETHNOMU'))
      ethnmus = T.must(SubjectArea.find_by(code: 'ETHNMUS'))
      ethnomu.superseding_subject_area = ethnmus
      ethnomu.save!

      # European Studies
      eur_std = T.must(SubjectArea.find_by(code: 'EUR STD'))
      euro_st = T.must(SubjectArea.find_by(code: 'EURO ST'))
      eur_std.superseding_subject_area = euro_st
      eur_std.save!

      # Film and Television
      film_and_tv = T.must(SubjectArea.find_by(code: 'FILM&TV'))
      film_tv = T.must(SubjectArea.find_by(code: 'FILM TV'))
      film_and_tv.superseding_subject_area = film_tv
      film_and_tv.save!

      # French
      french = T.must(SubjectArea.find_by(code: 'FRENCH'))
      frnch = T.must(SubjectArea.find_by(code: 'FRNCH'))
      french.superseding_subject_area = frnch
      french.save!

      # Clusters
      ge_clst = T.must(SubjectArea.find_by(code: 'GE CLST'))
      cluster = T.must(SubjectArea.find_by(code: 'CLUSTER'))
      ge_clst.superseding_subject_area = cluster
      ge_clst.save!

      # Hungarian
      hungar = T.must(SubjectArea.find_by(code: 'HUNGAR'))
      hungrn = T.must(SubjectArea.find_by(code: 'HUNGRN'))
      hngar = T.must(SubjectArea.find_by(code: 'HNGAR'))
      hungar.superseding_subject_area = hungrn
      hungrn.superseding_subject_area = hngar
      hungar.save!
      hungrn.save!

      # Indigenous Languages of the Americas
      ila = T.must(SubjectArea.find_by(code: 'ILA'))
      il_amer = T.must(SubjectArea.find_by(code: 'IL AMER'))
      ila.superseding_subject_area = il_amer
      ila.save!

      # International Development Studies
      int_dev = T.must(SubjectArea.find_by(code: 'INT DEV'))
      intl_dv = T.must(SubjectArea.find_by(code: 'INTL DV'))
      int_dev.superseding_subject_area = intl_dv
      int_dev.save!

      # Islamic Studies
      isl_std = T.must(SubjectArea.find_by(code: 'ISL STD'))
      islm_st = T.must(SubjectArea.find_by(code: 'ISLM ST'))
      isl_std.superseding_subject_area = islm_st
      isl_std.save!

      # Japanese
      japanse = T.must(SubjectArea.find_by(code: 'JAPANSE'))
      japan = T.must(SubjectArea.find_by(code: 'JAPAN'))
      japanse.superseding_subject_area = japan
      japanse.save!

      # Korean
      korean = T.must(SubjectArea.find_by(code: 'KOREAN'))
      korea = T.must(SubjectArea.find_by(code: 'KOREA'))
      korean.superseding_subject_area = korea
      korean.save!

      # Labor Studies
      lbr_and_ws = T.must(SubjectArea.find_by(code: 'LBR&WS'))
      lbr_std = T.must(SubjectArea.find_by(code: 'LBR STD'))
      lbr_and_ws.superseding_subject_area = lbr_std
      lbr_and_ws.save!

      # Latin American Studies
      lat_am = T.must(SubjectArea.find_by(code: 'LAT AM'))
      latn_am = T.must(SubjectArea.find_by(code: 'LATN AM'))
      lat_am.superseding_subject_area = latn_am
      lat_am.save!

      # LGBTQ Studies
      lgbts = T.must(SubjectArea.find_by(code: 'LGBTS'))
      lgbtqs = T.must(SubjectArea.find_by(code: 'LGBTQS'))
      lgbts.superseding_subject_area = lgbtqs
      lgbts.save!

      # Lithuanian
      lithuan = T.must(SubjectArea.find_by(code: 'LITHUAN'))
      lthuan = T.must(SubjectArea.find_by(code: 'LTHUAN'))
      lithuan.superseding_subject_area = lthuan
      lithuan.save!

      # Microbiology, Immunology, and Molecular Genetics
      microbio = T.must(SubjectArea.find_by(code: 'MICROB'))
      mic_and_imm = T.must(SubjectArea.find_by(code: 'MIC&IMM'))
      mimg = T.must(SubjectArea.find_by(code: 'MIMG'))
      microbio.superseding_subject_area = mic_and_imm
      mic_and_imm.superseding_subject_area = mimg
      microbio.save!
      mic_and_imm.save!

      # Middle Eastern Studies
      menas = T.must(SubjectArea.find_by(code: 'MENAS'))
      m_e_std = T.must(SubjectArea.find_by(code: 'M E STD'))
      menas.superseding_subject_area = m_e_std
      menas.save!

      # Music
      music = T.must(SubjectArea.find_by(code: 'MUSIC'))
      musc = T.must(SubjectArea.find_by(code: 'MUSC'))
      music.superseding_subject_area = musc
      music.save!

      # Music History
      mus_hst =  T.must(SubjectArea.find_by(code: 'MUS HST'))
      msc_hst =  T.must(SubjectArea.find_by(code: 'MSC HST'))
      mus_hst.superseding_subject_area = msc_hst
      mus_hst.save!

      # Music Industry
      mus_ind =  T.must(SubjectArea.find_by(code: 'MUS IND'))
      msc_ind =  T.must(SubjectArea.find_by(code: 'MSC IND'))
      mus_ind.superseding_subject_area = msc_ind
      mus_ind.save!

      # Musicology
      musclgy = T.must(SubjectArea.find_by(code: 'MUSCLGY'))
      musclg = T.must(SubjectArea.find_by(code: 'MUSCLG'))
      musclgy.superseding_subject_area = musclg
      musclgy.save!

      # Physiological Science
      phy_sci = T.must(SubjectArea.find_by(code: 'PHY SCI'))
      physci = T.must(SubjectArea.find_by(code: 'PHYSCI'))
      phy_sci.superseding_subject_area = physci
      phy_sci.save!

      # Polish
      polish = T.must(SubjectArea.find_by(code: 'POLISH'))
      polsh = T.must(SubjectArea.find_by(code: 'POLSH'))
      polish.superseding_subject_area = polsh
      polish.save!

      # Romanian
      roman = T.must(SubjectArea.find_by(code: 'ROMAN'))
      romania = T.must(SubjectArea.find_by(code: 'ROMANIA'))
      roman.superseding_subject_area = romania
      roman.save!

      # Russian
      russian = T.must(SubjectArea.find_by(code: 'RUSSIAN'))
      russn = T.must(SubjectArea.find_by(code: 'RUSSN'))
      russian.superseding_subject_area = russn
      russian.save!

      # Serbian/Croatian
      serbo = T.must(SubjectArea.find_by(code: 'SERBO'))
      ser_cro = T.must(SubjectArea.find_by(code: 'SER CRO'))
      srb_cro = T.must(SubjectArea.find_by(code: 'SRB CRO'))
      serbo.superseding_subject_area = ser_cro
      ser_cro.superseding_subject_area = srb_cro
      serbo.save!
      ser_cro.save!

      # Delete: Scheduling Room Hold
      sch_rm = SubjectArea.find_by(code: 'SCH RM')
      sch_rm&.destroy!

      # Slavic
      slavic = T.must(SubjectArea.find_by(code: 'SLAVIC'))
      slavc = T.must(SubjectArea.find_by(code: 'SLAVC'))
      slavic.superseding_subject_area = slavc
      slavic.save!

      # Social Welfare
      soc_wel = T.must(SubjectArea.find_by(code: 'SOC WEL'))
      soc_wlf = T.must(SubjectArea.find_by(code: 'SOC WLF'))
      soc_wel.superseding_subject_area = soc_wlf
      soc_wel.save!

      # Society and Genetics
      ampersand = T.must(SubjectArea.find_by(code: 'SOC&GEN'))
      no_ampersand = T.must(SubjectArea.find_by(code: 'SOC GEN'))
      ampersand.superseding_subject_area = no_ampersand

      # South Asian
      sa_std = T.must(SubjectArea.find_by(code: 'SA STD'))
      s_asian = T.must(SubjectArea.find_by(code: 'S ASIAN'))
      sa_std.superseding_subject_area = s_asian
      sa_std.save!

      # Southeast Asian
      se_asia = T.must(SubjectArea.find_by(code: 'SE ASIA'))
      se_a_st = T.must(SubjectArea.find_by(code: 'SE A ST'))
      seasian = T.must(SubjectArea.find_by(code: 'SEASIAN'))
      se_asia.superseding_subject_area = se_a_st
      se_a_st.superseding_subject_area = seasian
      se_asia.save!
      se_a_st.save!

      # Speech
      speech = T.must(SubjectArea.find_by(code: 'SPEECH'))
      spch = T.must(SubjectArea.find_by(code: 'SPCH'))
      speech.superseding_subject_area = spch
      spch.save!

      # Ukrainian
      ukrain = T.must(SubjectArea.find_by(code: 'UKRAIN'))
      ukrn = T.must(SubjectArea.find_by(code: 'UKRN'))
      ukrain.superseding_subject_area = ukrn
      ukrain.save!

      # Urban Planning
      urb_pln = T.must(SubjectArea.find_by(code: 'URB PLN'))
      urbn_pl = T.must(SubjectArea.find_by(code: 'URBN PL'))
      urb_pln.superseding_subject_area = urbn_pl
      urb_pln.save!

      # World Arts and Cultures
      wld_art = T.must(SubjectArea.find_by(code: 'WLD ART'))
      wl_arts = T.must(SubjectArea.find_by(code: 'WL ARTS'))
      wld_art.superseding_subject_area = wl_arts
      wld_art.save!

      # Gender/Women's Studies
      women_old = T.must(SubjectArea.find_by(code: 'WOMEN'))
      women_new = T.must(SubjectArea.find_by(code: 'WOM STD'))
      gender = T.must(SubjectArea.find_by(code: 'GENDER'))
      women_old.superseding_subject_area = women_new
      women_new.superseding_subject_area = gender
      women_old.save!
      women_new.save!

      # Yiddish
      yiddish_old = T.must(SubjectArea.find_by(code: 'YIDDISH'))
      yiddish_new = T.must(SubjectArea.find_by(code: 'YIDDSH'))
      yiddish_old.superseding_subject_area = yiddish_new
      yiddish_old.save!
    end
  end
end
