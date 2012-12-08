# select first_name, last_name, correct_solutions, incorrect_solutions from people join (select person_id, count(correct) as incorrect_solutions from submissions cs where correct = 'f' group by person_id) ic on ic.person_id = people.id join (select person_id, count(correct) as correct_solutions from submissions cs where correct = 't' group by person_id) cs on cs.person_id = people.id order by correct_solutions desc, incorrect_solutions asc;
#

class Ranking
  def rank_people(limit = 50, offset = 0)
    fields = "id, first_name, last_name, username, correct_submissions, incorrect_submissions"
    correct_solutions   = "(select person_id, count(correct) as correct_submissions from submissions cs where correct = 't' group by person_id)"
    incorrect_solutions = "(select person_id, count(correct) as incorrect_submissions from submissions cs where correct = 'f' group by person_id)"
    DB[:people].with_sql(
      "select #{fields} 
       from people p
        left join #{correct_solutions} cs
         on cs.person_id = p.id
        left join #{incorrect_solutions} ic
         on ic.person_id = p.id
       where role <> 'admin'
       order by correct_submissions desc, incorrect_submissions asc"
    )
  end
end

