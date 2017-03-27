# CalendarDemo

1 集成使用FSCalendar日历控件，注意系统自带的默认vc不会执行init方法，而是加载sb
2 block循环引用问题，用__weak typeof(self) weakSelf = self;解决
3 字典的key按照a-zA-Z自然排序，字典是无序的，数组是有序，只能根据key来相应的取value
