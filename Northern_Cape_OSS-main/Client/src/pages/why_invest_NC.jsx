import React from 'react';
import InfoCard from '../components/common/info_card';
import './why_invest_NC.css';

const stats = [
  {
    icon: "🏦",
    title: "Regional GDP Value",
    value: "R165 Billion",
  },
  {
    icon: "📊",
    title: "National GDP Contribution",
    value: "2.2%",
  },
  {
    icon: "👥",
    title: "Youthful Population",
    value: "65% Under 35",
  },
  {
    icon: "🌍",
    title: "Province Size",
    value: "30% of SA Land",
  },
];

export default function WhyInvestNC() {
  return (
    <div className="why-invest-page">
      <section className="why-invest-page__hero">
        <div className="hero-overlay"></div>
        <div className="why-invest-page__hero-content">
          <h1 className="hero-title">Why Invest in the Northern Cape?</h1>
          <p className="hero-subtitle">
            Unlock opportunities in South Africa's largest province. A strategic
            gateway to the Atlantic and SADC markets, driving the future of
            renewable energy and green hydrogen.
          </p>
          <div className="hero-cta">
            <button className="btn btn--primary">
              Explore Opportunities &rarr;
            </button>
            <button className="btn btn--secondary">
              Download Prospectus
            </button>
          </div>
        </div>
      </section>

      <section className="why-invest-page__stats">
        {stats.map((s, idx) => (
          <InfoCard
            key={idx}
            icon={s.icon}
            title={s.title}
            value={s.value}
          />
        ))}
      </section>
    </div>
  );
}
