module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /^the members dashboard$/
      members_dashboard_path

    when /^the admin dashboard$/
      admin_dashboard_path

    when /^the member(s?) sign in page$/
      new_member_session_path

    when /^the admin(s?) sign in page$/
      new_admin_session_path

    when /^the admin(s?) questions index$/
      admin_questions_path

    when /^the admin mock exams page$/
      admin_mock_exams_path

    when /^the admin subjects page$/
      admin_subjects_path

    when /^the disclaimer$/
      disclaimer_path

    when /^the contact/
      new_contact_path

    when /^the terms and conditions$/
      terms_and_conditions_path

    when /^the new exam revision page$/
      new_members_member_revision_exam_path

    when /^the new subscription page for the first product$/
      members_new_product_subscription_path(Product.first)

    when /^the first online revision show page$/i
      online_revision_path(Product.first)

    when /^the first question for the revision exam$/i
      members_member_revision_exam_member_exam_question_path(MemberRevisionExam.last, 1)

    when /^the first question for the mock exam$/i
      members_member_mock_exam_member_exam_question_path(MemberMockExam.last, 1)

    when /^the first question of the mock exam review$/i
      members_member_mock_exam_member_exam_question_path(MemberMockExam.last, 1)

    when /^the second question for the mock exam$/i
      members_member_mock_exam_member_exam_question_path(MemberMockExam.last, 2)

    when /^the second question for the revision exam$/i
      members_member_revision_exam_member_exam_question_path(MemberRevisionExam.last, 2)

    when /^the demo revision exam first question page$/i
      demo_member_revision_exam_member_exam_question_path(1, 1)

    when /^the new mock exam page$/i
      new_members_member_mock_exam_path

    when /^the first revision performance page$/i
      members_performance_revision_index_path(1)

    when /^the first admin question show page$/i
      admin_question_path(1)

    when /^the show page for the newly created topic$/i
      admin_topic_path(Topic.last)

    when /^the show page for the newly created admin$/i
      admin_admin_path(Admin.last)

    when /^the show page for the newly created mock exam/i
      admin_mock_exam_path(MockExam.last)

    when /^the show page for the newly created subject$/i
      admin_subject_path(Subject.last)

    when /^the first admin question explanation show page$/i
      admin_question_explanation_path(QuestionExplanation.last)

    when /^the first admin product show page$/i
      admin_product_path(1)

    when /^the first admin educational resource show page$/i
      admin_educational_resource_path(1)

    when /^the payment details page$/i
      payment_details_cart_path

    when /^the first members educational resources page$/
      members_educational_resource_path(1)

    when /^the browse all overview members educational resources page$/
      browse_overview_members_educational_resources_path(:all)

    when /^the browse owned overview members educational resources page$/
      browse_overview_members_educational_resources_path(:owned)

    when /^the admin first member page$/
      admin_member_path(1)

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
