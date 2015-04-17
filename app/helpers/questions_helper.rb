module QuestionsHelper
  def FillSubjectDropdown (subjects = Array.new)
    subjects_select = Array.new
    
    temp_sub =  Array.new
    temp_sub << "Todas"
    temp_sub << "0"
    subjects_select << temp_sub
    
    subjects.each do |subject|
      temp_sub =  Array.new
      temp_sub.push subject.name
      temp_sub.push subject.id
      subjects_select << temp_sub
    end
    return subjects_select 
  end
end
