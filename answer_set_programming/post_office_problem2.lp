% 
% Post office problem in ASP.
% 
% From Winston "Operations Research: Applications and Algorithms":
% """
% A post office requires a different number of full-time employees working 
% on different days of the week [summarized below]. Union rules state that 
% each full-time employee must work for 5 consecutive days and then receive 
% two days off. For example, an employee who works on Monday to Friday 
% must be off on Saturday and Sunday. The post office wants to meet its 
% daily requirements using only full-time employees. Minimize the number 
% of employees that must be hired.
%
% To summarize the important information about the problem:
%
%   * Every full-time worker works for 5 consecutive days and 
%     takes 2 days off
%   * Day 1 (Monday): 17 workers needed
%   * Day 2 : 13 workers needed
%   * Day 3 : 15 workers needed
%   * Day 4 : 19 workers needed
%   * Day 5 : 14 workers needed
%   * Day 6 : 16 workers needed
%   * Day 7 (Sunday) : 11 workers needed
%
% The post office needs to minimize the number of employees 
% it needs to hire to meet its demand. 
% """
%
% This was created by Hakan Kjellerstrand, hakank@bonetmail.com
% See also http://www.hakank.org/answer_set_programming/
%

% monday: 0, tuesday: 1, etc.
days(0..6).
workers(0..20).

% minimum need per day
need(0,17).
need(1,13).
need(2,15).
need(3,19).
need(4,14).
need(5,16).
need(6,11).


% Total cost for the 5 day schedule.
% Base cost per day is 100.
% Working saturday is 100 extra
% Working sunday is 200 extra.
cost(0, 500).
cost(1, 600).
cost(2, 800).
cost(3, 800).
cost(4, 800).
cost(5, 800).
cost(6, 700).

% index for day(Day, NumWorkers)
1 { day(Day, NumWorkers) : workers(NumWorkers) } 1 :- days(Day).


% for all days, ensure that there are minimum number of workers
Need #sum [ day(Day2, NumWorkers) : days(Day2) : workers(NumWorkers) : Day2 != (Day+5) #mod 7 : Day2 != (Day + 6) #mod 7 = NumWorkers ] :- days(Day), need(Day, Need).

#minimize [ day(Day, NumWorkers) = NumWorkers ].

% alternative objective: Minimize total cost
% #minimize [ day(Day, NumWorkers) : cost(Day, Cost) = NumWorkers*Cost ].

#hide.
#show day(D, N).
