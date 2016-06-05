package com.footmark.dao;

import java.util.List;

import com.footmark.model.Atd;
import com.footmark.model.AtdWall;
import com.footmark.model.User;

public interface AtdDAO {

	public boolean atd(User user, AtdWall wall,String atdinfo,String atdidentifier);
	public boolean isAtded(Long atdwallid,String atdidentifier);
	public List<Atd> findAllAtdBuyAtdWallid(Long atdwallid);
}
