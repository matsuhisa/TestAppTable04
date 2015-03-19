//  ViewController.swift
//  TestAppTable04

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    var memos = MemoDataController()

    var myToolbar: UIToolbar!
    @IBOutlet weak var MemoTable: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    //@IBOutlet weak var SearchBar: UISearchBar!
    
    override func viewDidLayoutSubviews() {
        // UISearchBar を最初は隠す
        // テーブルにあるデータが少ないと隠れない
        MemoTable.scrollToRowAtIndexPath(
            NSIndexPath(forRow: 0, inSection: 0),
            atScrollPosition: UITableViewScrollPosition.Top,
            animated: false
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //println(SearchBar.frame.height)
        
        // スターテスバー（statusBar）
        /*
        let statusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
        println(statusBarHeight)
        println(NSStringFromCGRect(self.view.frame))
        println(NSStringFromUIEdgeInsets(self.view.layoutMargins))
        println(UIEdgeInsetsInsetRect(self.view.frame, self.view.layoutMargins))
        */

        //MemoTable.contentInset = UIEdgeInsetsMake(100.0, 0.0, 0.0, 0.0)
        SearchBar.delegate = self
        SearchBar.showsCancelButton = true
        SearchBar.placeholder = "ここに入力してください"

        // 
        for key in 1...2 {
            var title = "メモです" + String(key)
            var body  = "本文です"
            var memo:Memo = Memo(title: title, body: body)
            memos.add(memo)
        }
        
        // ツールバーのサイズを決める.
        myToolbar = UIToolbar(frame: CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44.0))
        
        // ツールバーの位置を決める.
        myToolbar.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height-20.0)
        
        // ボタン１を生成する.
        let myUIBarButtonGreen: UIBarButtonItem = UIBarButtonItem(title: "追加", style:.Bordered, target: self, action: "onClickOpenInputView:")
        myUIBarButtonGreen.tag = 1
        
        // ボタン２を生成する.
        let myUIBarButtonBlue: UIBarButtonItem = UIBarButtonItem(title: "並び替え", style:.Bordered, target: self, action: "onClickSortButton:")
        myUIBarButtonBlue.tag = 2
        
        // ボタンをツールバーに入れる.
        myToolbar.items = [myUIBarButtonGreen, myUIBarButtonBlue]
        
        self.view.addSubview(myToolbar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - status
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        //return .LightContent
        return .BlackOpaque
    }

    
    /*
    テキストが変更される毎に呼ばれる
    */
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println("searchBar")
        println(searchText)
    }
    
    /*
    Cancelボタンが押された時に呼ばれる
    */
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        println("Cancelボタンが押された時に呼ばれる")
        SearchBar.text = "Cancelボタンが押された"
    }
    
    /*
    Searchボタンが押された時に呼ばれる
    */
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        println("------------")
        println("Searchボタンが押された")
        memos.search(SearchBar.text)
        self.MemoTable.reloadData()
        println("------------")
        
        
        //SearchBar.text = "Searchボタンが押された"
        //self.view.endEditing(true)
    }
    
    // MARK: - UITableの処理
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        var cell_object = memos.index(indexPath.row) as Memo
        cell.textLabel?.text = cell_object.title
        cell.detailTextLabel?.text = cell_object.created_at_string()
        //println(cell_object.title)
        return cell
    }
    
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return SearchBar
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SearchBar.frame.height
    }

    // MARK: - データの並び替え
    /**
    UIAlertController を呼び出す
    */
    func onClickSortButton(sender: UIBarButtonItem) {
        var alert = UIAlertController(title: "並び替え", message: "", preferredStyle: .ActionSheet)
        
        alert.addAction(UIAlertAction(title: "修正順", style: .Default) {
            action in NSLog("修正順")
        })
        
        
        alert.addAction(UIAlertAction(title: "作成順", style: .Default, handler: {(action:UIAlertAction!)-> Void in
            self.memos.sort_created_at()
            self.MemoTable.reloadData()
        }))

        alert.addAction( UIAlertAction(title: "キャンセル", style: .Cancel) {
            action in NSLog("キャンセル")
        })
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func onClickOpenInputView(sender: UIBarButtonItem) {
        var title = "メモです"
        var body  = "本文です"
        var memo:Memo = Memo(title: title, body: body)
        memos.add(memo)
        self.MemoTable.reloadData()
    }
}

