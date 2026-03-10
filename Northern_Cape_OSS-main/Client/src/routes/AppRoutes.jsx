import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import Home from '../pages/home.jsx';
import AboutUs from '../pages/about_us.jsx';
import ContactUs from '../pages/contact_us.jsx';
import InvestmentOpportunities from '../pages/investment_opportunities.jsx';
import KeySectors from '../pages/key_sectors.jsx';
import OneStopShop from '../pages/one_stop_shop.jsx';
import WhyInvestNC from '../pages/why_invest_NC.jsx';

export default function AppRoutes() {
  return (
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/about" element={<AboutUs />} />
      <Route path="/contact" element={<ContactUs />} />
      <Route path="/opportunities" element={<InvestmentOpportunities />} />
      <Route path="/sectors" element={<KeySectors />} />
      <Route path="/one-stop-shop" element={<OneStopShop />} />
      <Route path="/why-invest" element={<WhyInvestNC />} />
      {/* catch-all redirect back to home */}
      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  );
}

