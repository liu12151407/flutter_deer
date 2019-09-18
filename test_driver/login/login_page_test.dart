import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../tools/test_utils.dart';

void main() {

  group('登录部分：', (){
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDown((){
      print('< Success');
    });

    tearDownAll(() async {
      driver?.close();
    });
    
    test("登录页按钮点击",() async {
      await driver.tap(find.text("验证码登录"));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      await driver.tap(find.text("忘记密码"));
      await delayed();
      await driver.tap(find.byTooltip('Back'));
      await delayed();
      await driver.tap(find.text("还没账号？快去注册"));
    });

    test("注册页测试",() async {
      await driver.tap(find.text("获取验证码"));/// 无法成功触发事件，需要输入手机号
      
      var textField = find.byValueKey('phone');
      await driver.tap(textField);  // 点击输入框，给予焦点
      await driver.enterText('15000000000');  // 输入内容
      await delayed();
      
      await driver.tap(find.text("获取验证码"));
      
      var textField2 = find.byValueKey('vcode');
      await driver.tap(textField2);
      await driver.enterText('123456');
      await delayed();
      
      var textField3 = find.byValueKey('password');
      await driver.tap(textField3);
      await driver.enterText('111111');
      await delayed();

      await driver.tap(find.byValueKey('register')); // 点击注册
      
      // 清除输入框文字
      await driver.tap(find.byValueKey('password_delete'));

      await delayed();
      await driver.tap(find.byTooltip('Back'));
    }, timeout: const Timeout(Duration(seconds: 30)));

    test("登录页测试",() async {
      var textField = find.byValueKey('phone');
      await driver.tap(textField);
      await driver.enterText('15000000000');
      await delayed();
      var textField2 = find.byValueKey('password');
      await driver.tap(textField2);
      await driver.enterText('111111');
      await delayed();
      // 点击密码可见两次
      await driver.tap(find.byValueKey('password_showPwd'));
      await delayed();
      await driver.tap(find.byValueKey('password_showPwd'));
      await delayed();
      await driver.tap(find.byValueKey('login')); // 点击登录
    }, timeout: const Timeout(Duration(seconds: 30)));
  });
}