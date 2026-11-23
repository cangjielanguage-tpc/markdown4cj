```c
(void)addConditionWithKey:(const std::string &)key strVal:(const std::string &)strVal modifyUpdateReqItem:(std::vector<unifiedPublish::UniPubMatch> &)modifyUpdateReqItem {
    unifiedPublish::UniPubMatch addcondition = new unifiedPublish::UniPubMatch();
    addcondition->setkey(key);
    addcondition->setvalue(strVal);
    addcondition->setvaluetype(unifiedPublish::UniPubValueType::kString);
    modifyUpdateReqItem.pushback(addcondition);
}
```