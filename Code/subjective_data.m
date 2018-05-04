clear all; clc; close all;
%%
numQ = 8;
num_sub = 8;
task_order = {'PO','RE','RE','PO','RE','PO','PO','RE'}; %Phase 1 tasks FOR EACH SUBJECTS. 
responses_matrix_T1 = zeros(num_sub, numQ); %columns correspond to questions, rows correspond to subjects
responses_matrix_T2 = zeros(num_sub, numQ); %columns correspond to questions, rows correspond to subjects
responses_matrix_T1 = [4,4,6,6,2,1,1,1;
                    5,6,5,5,2,2,2,2;
                    5,6,6,6,2,2,2,2;
                    6,6,6,4,2,2,2,2;
                    3,3,7,7,2,2,1,1;
                    5,5,7,7,2,1,1,1;
                    5,6,6,7,2,2,2,2;
                    5,5,7,6,2,2,2,1];
responses_matrix_T2 = [ 4,4,5,6,2,2,1,1;
                        5,5,6,5,1,2,2,2;
                        3,3,5,6,2,2,1,1;
                        6,7,7,4,2,2,2,2;
                        5,4,6,7,2,1,2,2;
                        6,5,7,7,2,2,1,1;
                        5,6,6,7,2,2,2,2;
                        6,5,7,6,2,2,2,1];

%Q1: Control modes chosen by the system made task execution easier
%Q2: I liked operating the robots in the control modes chosen by the
%system. 
%Q3: The robot and I worked together to accomplish the task:
%Q4: I use a computer on a daily basis and I enjoy using new technology
%Q5: Which interface was the hardest to operate? 1- Joystick, 2-Headarray. 
%Q6: For which interface was the assistance paradigm the most useful?
%Q7: Which one of the schemes do you prefer the most? 1- without, 2- on
%demand
%Q8: Which one of the schemes is the most user-freindly? 1- without 2- on
%demand. 
%% 
responses = [responses_matrix_T1; responses_matrix_T2];
resp_add = responses_matrix_T1+responses_matrix_T2;
sum(resp_add(:, 7) > 2)


