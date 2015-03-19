//  MemoDataConroller.swift
//  TestAppTable04

import Foundation

class MemoDataController {
    
    var memos = NSMutableArray()
    
    init() {
    }
    
    func count()->Int {
        return memos.count
    }
    
    func add(memo:Memo) {
        // CoreDataに保存
        memos.addObject(memo)
    }
    
    func index(index_path:Int) ->Memo{
        return memos[index_path] as Memo
    }
    
    func sort_created_at(){
        let sortDescriptor:NSSortDescriptor = NSSortDescriptor(key: "created_at", ascending: false)
        self.memos.sortUsingDescriptors([sortDescriptor])
    }
    
    func search(keyword:String) {
        // 検索条件を作成
        let pred:NSPredicate = NSPredicate(format: "title = %@", keyword)
        memos.filterUsingPredicate(pred)
        //var _memos = self.memos
        //return _memos.filterUsingPredicate(pred)
    }
}
