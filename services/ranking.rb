# select first_name, last_name, correct_solutions, incorrect_solutions from people join (select person_id, count(correct) as incorrect_solutions from submissions cs where correct = 'f' group by person_id) ic on ic.person_id = people.id join (select person_id, count(correct) as correct_solutions from submissions cs where correct = 't' group by person_id) cs on cs.person_id = people.id order by correct_solutions desc, incorrect_solutions asc;
#

class Ranking
  def rank_people(limit = 50, offset = 0)
    fields = "id, first_name, last_name, username, correct_submissions, latest_correct, highest_correct"
    correct_solutions   = "(select person_id, count(correct) as correct_submissions from submissions where correct = 't' group by person_id)"
		latest_correct_solution = "(select person_id, answered_at as latest_correct from submissions where correct = 't' group by person_id order by answered_at desc)"
		highest_correct = "(select person_id, publish_date as highest_correct from submissions as s join questions as q on s.question_id = q.id  where s.correct = 't' group by s.person_id order by q.publish_date desc)"
#    incorrect_solutions = "(select person_id, count(correct) as incorrect_submissions from submissions where correct = 'f' group by person_id)"
    DB[:people].with_sql(
      "select #{fields} 
       from people p
        left join #{correct_solutions} cs
         on cs.person_id = p.id
				left join #{highest_correct} hc
				 on hc.person_id = p.id
				left join #{latest_correct_solution} ls
         on ls.person_id = p.id
       where role <> 'admin'
       order by correct_submissions desc, highest_correct desc, latest_correct asc"
    )
  end
end

