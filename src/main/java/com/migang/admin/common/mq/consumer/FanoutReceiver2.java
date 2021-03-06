package com.migang.admin.common.mq.consumer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.core.MessageListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSONObject;
import com.migang.admin.service.QueueService;

/**
 * 监听接收处理 Queue消息队列
 *
 * @param addTime 2017年9月7日
 * @param author     ChengBo
 */
@Component("rabbitＭqFanoutService2")
public class FanoutReceiver2 implements MessageListener {
	//引入日志操作类
	private Logger logger = LoggerFactory.getLogger(FanoutReceiver2.class);
	
	@Autowired
	private QueueService queueService;
	
	/**
	 * 接收消息
	 * 
	 * @param addTime 2017年9月7日
	 * @param author     ChengBo
	 */
	@Override
	public void onMessage(Message message) {
		//记录接收队列参数
		//logger.debug("FanoutQueue2消息消费者＝{}", message.toString());
		
		try {
			//接收队列参数转化为字符串
			String bodyMsg = new String(message.getBody(), "UTF-8");
			
			//解析请求Body中的JSON数据
			JSONObject jsonObject = JSONObject.parseObject(bodyMsg);
			
			//字符串转换成JSON串
			logger.debug("FanoutQueue2消息消费者接收JSON：{}", jsonObject);
			
			//处理消息内容
			queueService.dealQueueTask(jsonObject);
		} catch (Exception e) {
			//处理失败记录日志
			logger.debug("FanoutQueueReceiver2 onMessage exception: "+e.getMessage());
		}
	}
}
