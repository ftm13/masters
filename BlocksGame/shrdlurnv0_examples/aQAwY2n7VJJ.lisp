(example
  (id session:aQAwY2n7VJJ)
  (context (date 2017 3 9) (graph NaiveKnowledgeGraph ((string [[1,0],[0]]) (name b) (name c))))
  (timeStamp 2017-04-09T12:24:55.979)
  (NBestInd 0)
  (utterance "sort stacks")
  (targetFormula (call wallToString (call context:sortStacks)))
  (targetValue (string [[0],[1,0]]))
)
(example
  (id session:aQAwY2n7VJJ)
  (context (date 2017 3 9) (graph NaiveKnowledgeGraph ((string [[2,1,2,2],[1,1,2],[0],[0,1]]) (name b) (name c))))
  (timeStamp 2017-04-09T12:25:00.380)
  (NBestInd 0)
  (utterance "sort stacks")
  (targetFormula (call wallToString (call context:sortStacks)))
  (targetValue (string [[0],[0,1],[1,1,2],[2,1,2,2]]))
)